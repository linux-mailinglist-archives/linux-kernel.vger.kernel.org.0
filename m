Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D8641880
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 00:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436984AbfFKW56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 18:57:58 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37795 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436793AbfFKW55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 18:57:57 -0400
Received: by mail-it1-f193.google.com with SMTP id x22so7585931itl.2;
        Tue, 11 Jun 2019 15:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lmkaxpGfKDXdssVFFm0WWQxz39RGTvG0gTf4Y0p48n4=;
        b=IRzGOC3oejwfQriYuHWrZtYpDZKYb+yligduvNx5Ik98HfFxxMj76bTkIYdc8mnvW0
         llbX2NMuRqhfVWD2oQ0WeaTC5wRNcXWE1z8q23IKrzfzDALCXCeoU2R0IYQEgOZoD8bd
         HrOhCSW9DwuxVfXiBN3Watp1uNjRrYG5AtJgnfYfB1aC87Cul/z8eaigEtXyrnmRa8gK
         QOXWn0HWcALwv0/Tec8lGjf7w5WLUUqX6pcXaNMXFqEOpoCPC1fy6Q6+XwY3M+O+t1Lh
         s7/7/82iVBau3ZXkuq8L8BajgwsjFVgJWoz/2wpwfpgLrrrusXWyX61LV5NXv+UzHyOt
         hIzw==
X-Gm-Message-State: APjAAAWrdp70N/OGEqSCqSTUst6FzMLUxO4ePRNx4OGz3f0gcSIMq/K1
        JHcNezvFhWrYI/DPJPvklQ==
X-Google-Smtp-Source: APXvYqy0UyFUp0HcLidZZWaQ5Q2AZiuaGZqJRpMxMPnJHYbuAh+2deI17/ywBiA06Z4WubiGaiFzdA==
X-Received: by 2002:a24:c3c5:: with SMTP id s188mr20349397itg.168.1560293876746;
        Tue, 11 Jun 2019 15:57:56 -0700 (PDT)
Received: from localhost (ip-174-149-252-64.englco.spcsdns.net. [174.149.252.64])
        by smtp.gmail.com with ESMTPSA id r127sm2202388itr.7.2019.06.11.15.57.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 15:57:56 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:57:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt: bindings: mtd: brcmand: Add
 brcmnand,brcmnand-v7.3 support
Message-ID: <20190611225753.GA29277@bogus>
References: <1559659013-34502-1-git-send-email-kdasu.kdev@gmail.com>
 <1559659013-34502-3-git-send-email-kdasu.kdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559659013-34502-3-git-send-email-kdasu.kdev@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  4 Jun 2019 10:36:31 -0400, Kamal Dasu wrote:
> Added brcm,brcmnand-v7.3 as possible compatible string to support
> brcmnand controller v7.3.
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---
>  Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
