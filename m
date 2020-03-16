Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05B20186E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 16:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbgCPPcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 11:32:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37661 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731545AbgCPPcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:32:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id 3so2289062pff.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 08:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=83xo23e+WQ7K4J/Sc8OnREb/NVLDSRn9xWlDswkjGGk=;
        b=cvNgqb+DcMHBtISmR7axF5BH86jwjg5f1O1aF4IlzHo18PYxCoDe1DMYPiFFbkbNAM
         q+FGp1y9v5msQj7dgNbxV3u4XL4yQtCFGDUI7CiOs6VGba6EIH6zmxoU/iSKPJ7jis6W
         Nba+dAHd/ogk6dzEaV0PVxTfLAevmenMtPhdRjd3VYMfzElgJ4zc4VxCxqNgo6dUWdy0
         9A7Egm7orfggD/M6OwU7EPXpCIleFLGHn8xHN8S8ItTQlZWqwUspDd7NFvcUdkYdZlKw
         SQdTgPcB3d7Y+IOXLbQUo3ERwvTgDxmFAXTHyO2+T8HFJOUhrfsOYK1XMnFqKcQYpMKY
         yffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=83xo23e+WQ7K4J/Sc8OnREb/NVLDSRn9xWlDswkjGGk=;
        b=Pz/PiQrX87mWOq9l+45QvGxRnAtZaD0BNdGGZUeuzLdCCGLJ80pnHWnXThxf+LddAe
         FN686yKpshUHTru0eIY4dQ0ax/RB3tCaGECYu7W8TWUNW/LAzTmMsxpxuAyaSCiRhwsc
         US78YGHWFCctCFiEUNmNsJ4cdAeelU1lO0k17mt/LqQ7u0jZ7JgVWRq9/zNcz4Usir2K
         trJJtxa83aSIVokkLbi7TpZnvN5ooYvfQmHQ/li7tNDQA0wJFb3pn9uBn0NM2E/R/oen
         /Bxbss7o5FdhRMGnBYyCJajFGEHeTGWAn0VFby7g0UILcPSeL9l8Suoolm6mMVSARaii
         nnEA==
X-Gm-Message-State: ANhLgQ0Fvh9LRwBzayXUh4+fCBgJ3c93SZuB+kr1iRGU9HagQ6WGgCVT
        1t47PsID0g7pSLLpR2p4zDllNw==
X-Google-Smtp-Source: ADFU+vvl+5X8gQ/W8wKrpeBK6h+Edwd/nCycweqlaYHj7myxtzefST96jXFPLJX3ZSn4DwN+tkCFXw==
X-Received: by 2002:a63:a741:: with SMTP id w1mr407197pgo.131.1584372719859;
        Mon, 16 Mar 2020 08:31:59 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:dcc4:2a10:1b38:3edc])
        by smtp.gmail.com with ESMTPSA id d7sm298510pfa.106.2020.03.16.08.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Mar 2020 08:31:59 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] arm64: dts: meson-g12-common: add spicc controller nodes
In-Reply-To: <20200313091401.15888-1-narmstrong@baylibre.com>
References: <20200313091401.15888-1-narmstrong@baylibre.com>
Date:   Mon, 16 Mar 2020 08:31:58 -0700
Message-ID: <7hfte8wc29.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This adds the controller and pinctrl nodes for the Amlogic G12A SPICC
> controllers.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> Kevin,
>
> This depends on the CLKID_SPICC0_SCLK and CLKID_SPICC1_SCLK introduced
> in https://lore.kernel.org/linux-arm-kernel/20200219084928.28707-2-narmstrong@baylibre.com/

Looks like this is merged in clk-meson.  Can I get a stable tag to use
in my tree please?

Thanks,

Kevin
