Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF4C713D0B3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 00:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbgAOXkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 18:40:53 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34571 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbgAOXkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 18:40:53 -0500
Received: by mail-pj1-f68.google.com with SMTP id s94so2420366pjc.1;
        Wed, 15 Jan 2020 15:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AzbtYII6ZVOKx6F0wY5VC0oFwSgB112mnSOGZkVBBbM=;
        b=MCmVuyT4rQe2DIH3kN8C3aiPBlTcuRPbUqaB0AS6IkaQTDwQ851ULpadpoLfZEGZEI
         rt55jt+QGD1Oho4uKmWmc4dxDMmBvb9AUySg7ruTAjoshyxoTNOFj3GkZyhojMuVHysy
         bGyLReIheavsFYG9Uot0bLQUi5WOXaepzfz5EoJn183CPJrXVC3eTJUnuYx+8d4/nB5d
         QBaTdvZuU3ERzdholPzl2tiNwnc/TI5rYx8VijpeKTua1cAp2F0tf21T35KEkDD6zABE
         OyMdBv6rpQU9lNBZ6it5xXT4R5miXA2lrr0B8H6op+ZMKrGvn5E1AQHxzLGZeLoFcVu6
         ij0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AzbtYII6ZVOKx6F0wY5VC0oFwSgB112mnSOGZkVBBbM=;
        b=Q+xZvhp++jPWieuNymYmQC5R9EXox9jITDwGDw/M9HlE+CGkIaa43Ha+8pGxb++TpD
         AxmNoqhBkRnxWDM+JxN5QyKhgPh3EgqGXKa/JcW4gk6CNeQUfZZAKOOS3nFC2qcViKoX
         4w8KyT8L7hRt1ap+9VHIbM7rfysMqQpFU+MY7A1HxHEJGY4KZg4GiVVgATS6gYbHSyg4
         pVXvNVay8grnTZBjkUoRVkCH7vtxNk3U3E2AzHmbsXj3c7ncfBekCCA+JoLlNLS8PXCs
         gIGItmliRsYVhnEgqhO35RNboC7bz0cTUj/nhrEyB74GGVh1sZTaLCZytgYgbU5Pdbzd
         nT/A==
X-Gm-Message-State: APjAAAV4M8QY2i5X8489K5HsKrfYmOB5MiA0Z4PtV6KOPhZm0aeKfp/D
        K0LIq9R4xsBt7rrqtLdKlC0=
X-Google-Smtp-Source: APXvYqzQJQYQH9DjDTHOiuAVrravKNL8ADSaJjt7EbkacKAEQPVfGrTVHybO0GiGnbz3t1G4TQUvVw==
X-Received: by 2002:a17:90a:a409:: with SMTP id y9mr3020162pjp.119.1579131652518;
        Wed, 15 Jan 2020 15:40:52 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s21sm22905918pfe.20.2020.01.15.15.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 15:40:51 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>
Cc:     phil@raspberrypi.org, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: bcm283x: Unify CMA configuration
Date:   Wed, 15 Jan 2020 15:40:50 -0800
Message-Id: <20200115234050.30408-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110172935.19709-1-nsaenzjulienne@suse.de>
References: <20200110172935.19709-1-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 18:29:35 +0100, Nicolas Saenz Julienne <nsaenzjulienne@suse.de> wrote:
> With the introduction of the Raspberry Pi 4 we were forced to explicitly
> configure CMA's location, since arm64 defaults it into the ZONE_DMA32
> memory area, which is not good enough to perform DMA operations on that
> device. To bypass this limitation a dedicated CMA DT node was created,
> explicitly indicating the acceptable memory range and size.
> 
> That said, compatibility between boards is a must on the Raspberry Pi
> ecosystem so this creates a common CMA DT node so as for DT overlays to
> be able to update CMA's properties regardless of the board being used.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---

Applied to devicetree/next, thanks!
--
Florian
