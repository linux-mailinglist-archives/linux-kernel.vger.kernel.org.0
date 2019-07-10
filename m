Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25BE062D8A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 03:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfGIBhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 21:37:54 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34181 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfGIBhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:37:53 -0400
Received: by mail-io1-f67.google.com with SMTP id k8so39748622iot.1;
        Mon, 08 Jul 2019 18:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uOd/oGlrJQmGOyR3paSsUWyl32qF4mG/LZsN2EHNdm4=;
        b=Z+AjAYuzeRUo6uZgtvDXRRF8ZcDgTEOh7S2Kwiuigq3nw7PmIrkkjBUDpnP5UpbsOM
         za8UDFc9XxGzRZWvBNciO75xjZS5u+zVlVt4LuRxGBVsUd8F8EfJj60J3GNE6PHHdbGX
         dEOIA4Qae9Pe8nYmvytAUkpD6IiaYm5udQt2cs4VgmLt/uP4JFGlUvO8Hcb/DIBOp2HI
         +YLVSY38noLTjil0SxoWFLvUNMTlJmfoetGgmEGRlQ0ZNgsQVO1wQPSRl1y08GClMn8J
         r38eLQRu/Y11HkKvTgYHhzsljZNOy8hFALScCc7R4SH/NLcz5SooHb6bpGRcIuS/YF2N
         OXoQ==
X-Gm-Message-State: APjAAAU9AEEpQ1mUIuFzJdlDjfG8Qz7dEK3G/CLjtjcIRguLWhqWhHg2
        G9SmI38FPDO+hGZAYuv2TQ==
X-Google-Smtp-Source: APXvYqzGxBBE6CSBTeCLog4O9D6PQzOKAbZsak16GswGuWcEt/iesuaNho6fRp19X4r9iH6YUjkHcw==
X-Received: by 2002:a5e:9917:: with SMTP id t23mr7398839ioj.23.1562636272545;
        Mon, 08 Jul 2019 18:37:52 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s3sm13196924iob.49.2019.07.08.18.37.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 18:37:52 -0700 (PDT)
Date:   Mon, 8 Jul 2019 19:37:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     yongqiang.niu@mediatek.com
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: Re: [PATCH v3, 04/27] dt-bindings: mediatek: add dither description
 for mt8183 display
Message-ID: <20190709013750.GA30027@bogus>
References: <1559734986-7379-1-git-send-email-yongqiang.niu@mediatek.com>
 <1559734986-7379-5-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559734986-7379-5-git-send-email-yongqiang.niu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2019 19:42:43 +0800, <yongqiang.niu@mediatek.com> wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> Update device tree binding documention for the display subsystem for
> Mediatek MT8183 SOCs
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
