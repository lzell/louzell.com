<script type="text/javascript">
  // Slightly modifies the default exported pandoc html structure to help me apply light css styling.
  // Notes are kept with h2 tags representing dates. I want the dates to float to the left of the note.
  // I'll use `display:flex` on a parent, and have the h2 tags wrapped in a child div, and all of the h2
  // tag's sibling content wrapped in a second child div.
  document.addEventListener("DOMContentLoaded", function(event) {
    const h2tags = Array.from(document.body.children).filter(child => child.tagName == "H2")
    contentStructure = getDesiredContentStructure(h2tags)
    modifyDOM(contentStructure)
  });

  // Get the desired content structure.
  // This will take the form of the final DOM structure that I want under the body tag.
  // An example insert structure may look like this (note the nested lists):
  //
  // [
  //   [<h2:dateA>, [... all sibling content under dateA ... ]]
  //   [<h2:dateB>, [... all sibling content under dateB ... ]]
  //   ...
  // ]
  //
  //
  function getDesiredContentStructure(h2tags) {
    var contentStructure = []
    for (const h2tag of h2tags) {
      var innerContent = [h2tag, []]
      let walker = h2tag.nextSibling
      while (walker && walker.tagName != "H2") {
        innerContent[1].push(walker)
        walker = walker.nextSibling
      }
      contentStructure.push(innerContent)
    }
    return contentStructure
  }

  // Modify the DOM to satisfy the given `contentStructure`
  function modifyDOM(contentStructure) {
    for (const innerContent of contentStructure) {
      const entry = document.createElement("div")
      entry.setAttribute("class", "entry-wrapper")
      const entryDate = document.createElement("div")
      entryDate.setAttribute("class", "the-headers")
      const entryContent = document.createElement("div")
      entryContent.setAttribute("class", "the-contents")

      entryDate.appendChild(innerContent[0])
      for (const i of innerContent[1]) {
        entryContent.appendChild(i)
      }
      entry.appendChild(entryDate)
      entry.appendChild(entryContent)
      document.body.appendChild(entry)
    }
  }
</script>
