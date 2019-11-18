Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42CB9100DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 22:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfKRVcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 16:32:05 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40801 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRVcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:32:05 -0500
Received: by mail-ot1-f66.google.com with SMTP id m15so15890868otq.7;
        Mon, 18 Nov 2019 13:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qqYcsKRMT/Ofwu9p9gWIeiSVzyiJC1qQZAiQjgxWaa0=;
        b=p8LECv3CiHHofjdz3aN4U7ivWyq3FKyFsvBrhfxDUjiMEa76c1DonaFk8SfugP5t5f
         +Iguo5gzOW10ON8om+yZqyaLSbAljf/cCQMJsT2LJHTAxLBvmgY43VKw+eLO1yLv47nb
         z/BB5h0eU4a0y+EJxVy7igR2zPrR1WqOJsSHMsNTP02AU7aG5oSo7sK2AsnMlGlyZo6P
         DTMBzbLACNR8x9kVbGeROGVrBL8cec+VpSUv7z17UElYWfcm3LRoB8iLSa+1dGkNUTKE
         P8+3tHQn/Axbf1FKSnCOIS8KP4FkMSYJx14gbvO97EPIICiXqptzvIwT7yT7WxM9odb5
         kMwg==
X-Gm-Message-State: APjAAAUMyLvNStdOdRod2EM+mgXRzYtfdDfwrgseHnevQajWQyYv/Bm+
        Tp5+g6bppvZz7mJ/mELhug==
X-Google-Smtp-Source: APXvYqy5qVSVt+xh2wIzi24hrKLRfXyk0CYioZ9gFcoETioNwzK7Xkbr7IosaBgrxrtdWzERUqCG4w==
X-Received: by 2002:a05:6830:50:: with SMTP id d16mr1039391otp.132.1574112722863;
        Mon, 18 Nov 2019 13:32:02 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p3sm6570097oti.22.2019.11.18.13.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 13:32:02 -0800 (PST)
Date:   Mon, 18 Nov 2019 15:32:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ming-Fan Chen <ming-fan.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Evan Green <evgreen@chromium.org>,
        Joerg Roedel <jroedel@suse.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Ming-Fan Chen <ming-fan.chen@mediatek.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: mediatek: Add binding for MT6779 SMI
Message-ID: <20191118213201.GA27040@bogus>
References: <1573616362-2557-1-git-send-email-ming-fan.chen@mediatek.com>
 <1573616362-2557-2-git-send-email-ming-fan.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573616362-2557-2-git-send-email-ming-fan.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019 11:39:21 +0800, Ming-Fan Chen wrote:
> This patch add description for MT6779 SMI.
> 
> Signed-off-by: Ming-Fan Chen <ming-fan.chen@mediatek.com>
> ---
>  .../memory-controllers/mediatek,smi-common.txt     |    3 ++-
>  .../memory-controllers/mediatek,smi-larb.txt       |    3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
