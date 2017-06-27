<div class="copyright" >
  {% set current = date(Date.now(), "YYYY") %}
  &copy; {% if theme.since and theme.since != current %} {{ theme.since }} - {% endif %}
  <span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="fa fa-{{ theme.authoricon }}"></i>
  </span>
  <!--
  <span class="author" itemprop="copyrightHolder">{{ config.author }}</span>
  -->
  <span><a href="http://www.miitbeian.gov.cn/" target="_blank">皖ICP备17014665号</span>
</div>
