Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E735A93DE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 22:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbfIDUjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 16:39:16 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:33143 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfIDUjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 16:39:16 -0400
Received: by mail-qt1-f172.google.com with SMTP id r5so108632qtd.0;
        Wed, 04 Sep 2019 13:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbgwxnHgS6hIfm6RfGBr/CxFsi18uynnBvYt+OjK65k=;
        b=H/oGIA3U76K8T1siZ+8ir/jGB2QuHZc3gKXba4oKrr9y8/JJc4ylEanXdgdvvSrLE2
         vk8zKqR9OOVC746bOYg+ts5z6CUUztfMESclO2g5IlCJz69lwyoCySZmLjLpoK/uCUSC
         AXld/VBi9h80yjTWtdNlJFmzvHvMqVLADXRztBpP4D2NxM1d4cb8Ejej1H9wgsAN/qpu
         W7sLHOl52h3pQVhMRUFOGw0vSVo42xI9ILH+asizY0pdZWGlHGST+7Tt/GpSGik14btd
         5RtJqjRYqlXBofMHS/kEzSdQDmo3dZUBFgPmQ8x/74hmaAqXrM9sb/CO6nEiTziXTURg
         nJHg==
X-Gm-Message-State: APjAAAURys+0wuTTqGsgVcNHitjznvzvRvORH7UBB2kofVoAKoio7hkA
        fDqEhOz/I8BXG3A7o+p+n26kwnhp4Fi9m9WAAOc=
X-Google-Smtp-Source: APXvYqzbCg3GTxblfTAgpudUZnZzrBMXAHE/Z7Q8UhlurQm79KTIkweqzFldLMIK3rv1iZLxUJKQPEpnuk6crwjxsLM=
X-Received: by 2002:ac8:5306:: with SMTP id t6mr27903428qtn.204.1567629555155;
 Wed, 04 Sep 2019 13:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190904175002.10487-1-krzk@kernel.org> <20190904175002.10487-4-krzk@kernel.org>
In-Reply-To: <20190904175002.10487-4-krzk@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 4 Sep 2019 22:38:59 +0200
Message-ID: <CAK8P3a0mSMBRWGHFH4E5CtFWD=F4xs+YSt+ZZY=qPjP2At8shQ@mail.gmail.com>
Subject: Re: [GIT PULL 3/5] ARM: dts: exynos: Second pull for v5.4
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 7:50 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Samsung DTS ARM changes for v5.4, part 2
>
> 1. Fix Exynos542x Chromebooks boot with multi_v7 defconfig,
> 2. Add GPU (Mali) support to Exynos5250 boards,
> 3. Minor cleanup for Exynos3250 ADC.
>

Pulled into arm/dt, thanks!

       Arnd
