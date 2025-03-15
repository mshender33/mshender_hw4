def entry_params
  params.require(:entry).permit(:title, :description, :date, :image)
end
