<template>
<div class="view-wrapper">
  <div class="info">
    <div class="avatar">
      <img src="../../../assets/logo.png" alt="">
    </div>
    <div class="msg-info">
      <div class="name">{{ config.name }}</div>
      <div class="date">{{ config.date }}</div>
    </div>
  </div>
  <div class="content">
    {{ config.content }}
  </div>
</div>
</template>

<script>
export default {
  props: {
    config: Object,
    default: () => ({})
  }
}
</script>

<style lang="scss" scoped>
@mixin str-cut ($width) {
  width: $width;
  overflow: hidden;
  text-overflow: ellipsis;
}
.view-wrapper {
  display: flex;
  justify-content: space-around;
  .info {
    height: 38px;
    width: 250px;
    display: flex;
    .avatar {
      width: 38px;
      height: 38px;
      margin-right: 10px;
      img {
        width: 100%;
        height: 100%;
      }
    }
    .msg-info {
      display: flex;
      flex: 1;
      flex-direction: column;
      justify-content: space-around;
      height: 100%;
      line-height: 100%;
      .name {
        color: #41B883;
        @include str-cut(80px);
      }
      .date {
        color: #41B883;
        font-size: 12px;
      }
    }
  }
  .content {
    width: 100%;
  }
}
</style>
