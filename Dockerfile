FROM ruby:3.2-slim

# 네이티브 확장 컴파일을 위한 필수 패키지 및 Git 설치
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    build-essential \
    zlib1g-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 컨테이너 내 작업 디렉토리 정의
WORKDIR /srv/jekyll

# 젬(Gem) 설치 경로 고정 및 환경 변수 등록 (Named Volume 바인딩용)
ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_BIN=/usr/local/bundle/bin \
    GEM_HOME=/usr/local/bundle
ENV PATH=$BUNDLE_BIN:$PATH

# Jekyll 기본 포트 노출
EXPOSE 4000

# 기본 실행 명령 (컨테이너 가동 시 서버 자동 실행)
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--force_polling"]