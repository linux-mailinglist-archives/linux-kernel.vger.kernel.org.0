Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD904D4367
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 16:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfJKOuo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Oct 2019 10:50:44 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44204 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfJKOuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:50:44 -0400
Received: by mail-oi1-f194.google.com with SMTP id w6so8172950oie.11;
        Fri, 11 Oct 2019 07:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gryLhIXL4l6QqVF4jY3/Zduxk2LABaCpupxRbGKjliY=;
        b=d30V+8FIO1t3w+baoSS+aweEqKKAmyJe75JDm0mJ2aXXlezDSHdW86uquvP77GpQXa
         OPWPIrXiwOPfEWiHRf/2jHoi0jOB28bEHsvrslb4O95NquJap7+NzFTKACXx0C1tk7TT
         ecRhLCn6jRzPIdBxpgwSyjtGM22E0HSrgCFyXmZdO2Qkaq2Wfz0TpfOAXm+TrqiHAvit
         sPB4f0BE5pKULbBrNSVADwYGjR98gPgyCakcLdnORCuYh+StRMZ3ADIJAgV2t07hfkE2
         YpHTT81Amy/sfXmDfgSNCadAi0MCJE2KYwVH8lWhWdyVp7QpHtXeneilE9gCPeM+4ANB
         zveg==
X-Gm-Message-State: APjAAAVvVuNppd4iASDcBNymVfFb3h0CS6nNhcb+x3UiqagPaHiufC2L
        HTbzfLq5AZz9oMIiIRwdzXdmrks=
X-Google-Smtp-Source: APXvYqw4tg27DOTO+ilupZjHUfUpz2Sf7rFACQOxDJK44IZFRl4/ElfBF+Wwbk3Nyc8kNUvRcmX/Yg==
X-Received: by 2002:aca:abd2:: with SMTP id u201mr12259123oie.105.1570805443172;
        Fri, 11 Oct 2019 07:50:43 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v7sm1182819oic.9.2019.10.11.07.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 07:50:42 -0700 (PDT)
Date:   Fri, 11 Oct 2019 09:50:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Laurentiu Palcu <laurentiu.palcu@nxp.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, agx@sigxcpu.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/5] dt-bindings: display: imx: add bindings for DCSS
Message-ID: <20191011145042.GA15680@bogus>
References: <1570025100-5634-1-git-send-email-laurentiu.palcu@nxp.com>
 <1570025100-5634-5-git-send-email-laurentiu.palcu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1570025100-5634-5-git-send-email-laurentiu.palcu@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

:u?wc??m5?^?㞾?}4-??z{b???r?+?׀u???ا????#????ek ?????W?J????^?(???h}??-??z{b???r?Z????+?jW.?\?oۊwb??v+)????l?b?&??,?&??ξ????????????????W???!jxw΢?ǫ?*'??+y?^??^?M:???r鞞֭???u??q?ky?ۊwb??v+)????l?b?&??,?&?????u????ޮ?????G???h
