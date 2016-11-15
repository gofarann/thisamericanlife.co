module EpisodesHelper

  def import_button
    if new_episodes?
      link_to "IMPORT NEW EPISODES", import_path, class: "btn btn-lg btn-primary btn-block"
    end
  end

end
