RSpec.describe RuboCop::Cop::MemoryManagement::UnpairedResource, :config do
  pairs_config = {
    'Pairs' => {
      'begin_drawing' => 'end_drawing',
      'begin_mode_2d' => 'end_mode_2d',
      'begin_mode_3d' => 'end_mode_3d',
      'begin_texture_mode' => 'end_texture_mode',
      'begin_shader_mode' => 'end_shader_mode',
      'begin_blend_mode' => 'end_blend_mode',
      'begin_scissor_mode' => 'end_scissor_mode',
      'begin_vr_stereo_mode' => 'end_vr_stereo_mode',
      'init_window' => 'close_window',
      'load_directory_files' => 'unload_directory_files',
      'load_dropped_files' => 'unload_dropped_files',
      'load_file_data' => 'unload_file_data',
      'load_file_text' => 'unload_file_text',
      'load_shader' => 'unload_shader',
      'load_shader_from_memory' => 'unload_shader',
      'load_vr_stereo_config' => 'unload_vr_stereo_config',
      'load_image' => 'unload_image',
      'load_texture' => 'unload_texture',
      'load_render_texture' => 'unload_render_texture',
      'load_font' => 'unload_font',
      'load_font_ex' => 'unload_font',
      'load_font_from_image' => 'unload_font',
      'load_font_from_memory' => 'unload_font',
      'load_font_data' => 'unload_font_data',
      'gen_image_font_atlas' => 'unload_font_data',
      'load_model' => 'unload_model',
      'load_model_animations' => 'unload_model_animation',
      'load_materials' => 'unload_material',
      'init_audio_device' => 'close_audio_device',
      'load_wave' => 'unload_wave',
      'load_sound' => 'unload_sound',
      'load_music_stream' => 'unload_music_stream',
      'load_audio_stream' => 'unload_audio_stream'
    }
  }

  pairs_config['Pairs'].each do |init_method, close_method|
    context "with init_method: #{init_method} and close_method: #{close_method}" do
      let(:msg) { "Found `#{init_method}` without a corresponding `#{close_method}`." }

      context "when #{init_method} is called without a corresponding #{close_method}" do
        it 'registers an offense' do
          expect_offense(<<~RUBY)
            Raylib.#{init_method}
            ^^^^^^^#{'^' * init_method.length} #{msg}
          RUBY
        end
      end

      context "when #{init_method} is called with a corresponding #{close_method}" do
        it 'does not register an offense' do
          expect_no_offenses(<<~RUBY)
            Raylib.#{init_method}
            Raylib.other_method
            Raylib.#{close_method}
          RUBY
        end
      end

      context "when multiple #{init_method} are called without corresponding #{close_method}" do
        it 'registers multiple offenses' do
          expect_offense(<<~RUBY)
            Raylib.#{init_method}
            ^^^^^^^#{'^' * init_method.length} #{msg}
            Raylib.#{init_method}
            ^^^^^^^#{'^' * init_method.length} #{msg}
          RUBY
        end
      end

      context "when multiple #{init_method} are called with corresponding #{close_method} for each" do
        it 'does not register offenses' do
          expect_no_offenses(<<~RUBY)
            Raylib.#{init_method}
            Raylib.#{close_method}
            Raylib.#{init_method}
            Raylib.#{close_method}
          RUBY
        end
      end

      context "when no #{init_method} is called" do
        it 'does not register offenses' do
          expect_no_offenses(<<~RUBY)
            Raylib.some_other_method
          RUBY
        end
      end

      context "when #{init_method} and #{close_method} are interleaved" do
        it 'registers an offense' do
          expect_offense(<<~RUBY)
            Raylib.#{init_method}
            Raylib.#{close_method}
            Raylib.#{init_method}
            ^^^^^^^#{'^' * init_method.length} #{msg}
          RUBY
        end
      end

      context "when #{close_method} is called before #{init_method}" do
        it 'does not register offenses' do
          expect_no_offenses(<<~RUBY)
            Raylib.#{close_method}
            Raylib.#{init_method}
            Raylib.#{close_method}
          RUBY
        end
      end
    end
  end
end
