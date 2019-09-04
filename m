Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0A0A7F88
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 11:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfIDJhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 05:37:46 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41962 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfIDJhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:37:45 -0400
Received: by mail-lf1-f68.google.com with SMTP id j4so15335071lfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 02:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1TzNHPbRq5zNIv1iOC09GFzfffcLUg+5sXUEA4GwN8g=;
        b=D5P8KzYZ+wS99V7EB1zdAtDFdRFRB9XOncDw3jWcOfsxZEoiBlSGvo3X07oyPz5RMj
         dpdqtplDzil9bUSuvUlkaD2rXJpmzqqfIwtQ8YCZ2YPfHOciKQNFTXrjXbnkHl7Q/VrO
         qqU9YPwQdi4/eYnc5IU75V4qEq71N+hd1m/HXnQksgIz48fFzpsoY+zEc97wCWKddqkY
         bLB83ig6R2HefBrlEsMSMyEpHFXp4PNA+Xy2HlbC/5CREzL3LWR/xhWX1SW9sPT8UlTN
         kUU2oOu1YYj8N1AVYNeqn5vS/TiW2h+8KSrbmTSj4sLlrwLXSELnfeBh32FtHPHq4bBr
         SlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1TzNHPbRq5zNIv1iOC09GFzfffcLUg+5sXUEA4GwN8g=;
        b=rkAawxmSqz//Ol1cPP1AT1KbXIOagEZc7/rZTeeqfseEwOywLG1ddsoZj3frOQA50N
         BR0CtK2tv1TSpeop4AIbXrlVzV5rCz7f6maVmQtzpGi/MZC5lpOhAY/FTG5SdRARplpa
         puJlTcao0F0+sPSR8wI7G5m+BIR8ZDXM11wLYfpjU6U8xybMuGPpvTW1yWuF8zP5O3pC
         1ilAnVUCELuI4TX8VoPqdgsM86rGuOhTtbs85kM6g4QvSsWyJj1+AcGwh0gGXx6ICIB1
         AhPd1DVa8NTh7IefSvb0RzL6+29wmY2z289F2s69rd3OlqdfR8o8F8ni20PwwEwOrcTt
         rMlw==
X-Gm-Message-State: APjAAAU3sxo2fTOmfvJFWy6bPcmX6RREjB65sowScfAJC270+tSAoj9t
        17fisN+TFmf1k6Bn+qz1ClftFvHTPW4ei8YjGAs=
X-Google-Smtp-Source: APXvYqzaYsKbOUO3cxqwwNucWf+GMrDe9WE5k3mEvzU0eRHcc3NfPyKYxnTd5Kxlhqn9N3eunjM/wENWFwScfZE8dPs=
X-Received: by 2002:a19:f806:: with SMTP id a6mr4246807lff.151.1567589863634;
 Wed, 04 Sep 2019 02:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190508174347.13901-1-borneo.antonio@gmail.com>
In-Reply-To: <20190508174347.13901-1-borneo.antonio@gmail.com>
From:   Antonio Borneo <borneo.antonio@gmail.com>
Date:   Wed, 4 Sep 2019 11:37:23 +0200
Message-ID: <CAAj6DX1KvpYM+xc+dho8tkbMDxGBKAFaenqXYKaU5qYVVUvrzg@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: fix multiple const * types
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

can this series be queued for merge ?

I just found I mess-up the mail thread references, so here are the
latest versions:

[1/4 V2] https://lore.kernel.org/lkml/20190508174347.13901-1-borneo.antonio@gmail.com/
[2/4] dropped
[3/4] https://lore.kernel.org/lkml/20190508122721.7513-3-borneo.antonio@gmail.com/
[4/4 V5] https://lore.kernel.org/lkml/20190508122721.7513-3-borneo.antonio@gmail.com/

Thanks,
Antonio
