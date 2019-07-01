Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A1444D74
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 22:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbfFMU36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 16:29:58 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36871 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfFMU36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:29:58 -0400
Received: by mail-qt1-f196.google.com with SMTP id y57so24201211qtk.4;
        Thu, 13 Jun 2019 13:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q2W9IgO+Pe6i1WAFkf2iukORqFWWBYZf6QLHmSp3BkA=;
        b=Yh8MZWMBpTGKX1iVyTQCpVnfxpAAgQhSODVw1u+pp1MtTd40FwXoi1rSjuxcPcqsr1
         QVSmj76EbJV7lwis7buHrq7TmQW46PWZNJlaVGmPFR2ugsK1PoX6SttnwO78HLRQUVJ7
         8Zxn79z4MKzoDOSuGFF6aIlyjShdGlXyhSMKWn+oIz0+isOEEAaNVJWWkLq7kjHo0Dx8
         pkMf0lOJsGD7vqUVm/EQllKB3Et5DlEHGW+jQZrpV3yQbMCTZ2lhnT6GatOFiZjXp5cw
         QNfSw04hABk+sXRnO1NdBJTawbGqEugSLCNt2CEd8Ql/riyIrTYb6pKIq6aEAD8KFcmq
         jkAg==
X-Gm-Message-State: APjAAAVEopO7eEAgww6dlD+NqeEoswa/Arq5bRiTgpm+/y1qz62r8NCn
        GMI8324ygjCNekzSyw7rwFWkaPQ=
X-Google-Smtp-Source: APXvYqwqfWuM/erWRPw6zM7jFj71l0/SCr2QTQZEniQOedhiT/JJF1KSiP+dUIuhqA3/gdNtt+nVfQ==
X-Received: by 2002:ac8:156:: with SMTP id f22mr58679280qtg.58.1560457797041;
        Thu, 13 Jun 2019 13:29:57 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id y42sm565705qtc.66.2019.06.13.13.29.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 13:29:56 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:29:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] dt-bindings: property-units: Sanitize unit naming
Message-ID: <20190613202955.GA22441@bogus>
References: <20190514085024.17587-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514085024.17587-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2019 10:50:24 +0200, Geert Uytterhoeven wrote:
> Make the naming of units consistent with common practices:
>   - Do not capitalize the first character of units ("Celsius" is
>     special, as it is not the unit name, but a reference to its
>     proposer),
>   - Do not use plural for units,
>   - Do not abbreviate "ampere",
>   - Concatenate prefixes and units (no spaces or hyphens),
>   - Separate units by spaces not hyphens,
>   - "milli" applies to "degree", not to "Celsius".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/property-units.txt    | 34 +++++++++----------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 

Applied, thanks.

Rob
