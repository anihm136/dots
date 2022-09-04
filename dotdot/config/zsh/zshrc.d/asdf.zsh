{%@@ if profile != "anihm2" @@%}
# Load ASDF
[[ -f ${ASDF_DIR}/asdf.sh ]] && source ${ASDF_DIR}/asdf.sh

# Set $JAVA_HOME using ASDF
source "$ASDF_DATA_DIR/plugins/java/set-java-home.zsh"
{%@@ endif @@%}
