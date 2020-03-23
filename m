Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2708B1900F6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 23:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgCWWLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 18:11:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:47041 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgCWWLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 18:11:36 -0400
Received: by mail-io1-f68.google.com with SMTP id a20so8817136ioo.13;
        Mon, 23 Mar 2020 15:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CXIO1RuJbIyd33SKijqeKvFhxWfXHto+5uHWG1/sMRA=;
        b=Jo+uVqYREiI0mWPuKlCZREz+i9Rre27xwTSP2BPp5WO9QOiJUcR6VMOUoWrXsMT0/q
         Z/rom6oKwB0I7PvStUmKSXaI7gcKku17WFH8sD3ps5OyJicg3fzPN5MbGKa8FecnoaP+
         QbJkXfb4QXDywHhMFAw9MwwY2CcO6bR+85JK/Y5tloMM9N3Y7piuLGzhAvKO5OOB+fqt
         ihmnLpPumymS5tqhlttL4WoQXa+IjmkWAZ8y+TYwo7p4eOey5vfoAm94gylsFMkGgjK2
         2+FzkFNsOtt6C2C5Iu0+342IVhVCH8SG6IGpNIcqTi2FyhlPvkf9zoeG4UZYv93Zgfi4
         hxnQ==
X-Gm-Message-State: ANhLgQ0/DM+7D02sNHEF6udqTWYkjyYD2EQm+QqHcuPYa6Ia/KZM/ooz
        vpRPeis4rwo5qSuQwk/fJA==
X-Google-Smtp-Source: ADFU+vuxvKf/q1ZfFJJiZuqcHHfTUME8CXHg4jNa1UZ/F14DpnV8NJR/r/bzHrCDo4Qu5Piq/XFZzg==
X-Received: by 2002:a5d:958f:: with SMTP id a15mr20875411ioo.170.1585001495416;
        Mon, 23 Mar 2020 15:11:35 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h9sm414079iow.37.2020.03.23.15.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 15:11:34 -0700 (PDT)
Received: (nullmailer pid 28519 invoked by uid 1000);
        Mon, 23 Mar 2020 22:11:33 -0000
Date:   Mon, 23 Mar 2020 16:11:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, heiko@sntech.de,
        robh+dt@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: sound: convert rockchip i2s bindings
 to yaml
Message-ID: <20200323221133.GA28453@bogus>
References: <20200311174322.23813-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311174322.23813-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 18:43:21 +0100, Johan Jonker wrote:
> Current dts files with 'i2s' nodes are manually verified.
> In order to automate this process rockchip-i2s.txt
> has to be converted to yaml.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/sound/rockchip-i2s.txt     |  49 ----------
>  .../devicetree/bindings/sound/rockchip-i2s.yaml    | 106 +++++++++++++++++++++
>  2 files changed, 106 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/rockchip-i2s.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
