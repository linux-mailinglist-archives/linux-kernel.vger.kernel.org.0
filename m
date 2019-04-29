Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0977E95E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 19:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfD2RlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 13:41:00 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38902 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfD2RlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:41:00 -0400
Received: by mail-ot1-f68.google.com with SMTP id t20so9417567otl.5;
        Mon, 29 Apr 2019 10:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7IAkFL1JXbZxNJHIArZ/p7tWmdMrEZfFKxFB5D31v3Y=;
        b=VmQFGNP/nKKOhIUzJ6tcKCvl4vYB0joCjFX7IZetchwivtU3Y6Cx36a4LOOHERgQCi
         ZyL746Mm8gmpwWJanVyKlG2DljbQpvnPTpiU+kc2tx2IY2hhaRS6N0JsrDais1q2osC/
         6qmPa87EMRtsiW6j2cEi8bjvFjsA5NyHKeXd9j7UMHICCdZ+V3mOwx17AKbg8xfaCHDc
         Yr34h70JcbsffAeGVXtOkWTAFqDyGNX19FpYqgTTnM2VEnEszVrQMHv/CfCHKimppxC8
         0ID6jFw9BSzDc6wCGlRwkWoYdBicOF+bSQJwIq69m443vE1TszyrNfMwTX7MrXSFsnIX
         aJ/A==
X-Gm-Message-State: APjAAAUfchWPbMBiIiDdCvfH5MFTDiyLv3a7hqdOlBg8z1tFE1/4Xv5L
        ANoYQSnKQwbqApxImdCmLA==
X-Google-Smtp-Source: APXvYqw/imxgz09DG6zdb1MmzjQVdBUe8PLv9+NKHbFUlUVCLnjIkMVGwh0dmC1m3Zg49hHRfgn0uw==
X-Received: by 2002:a9d:4909:: with SMTP id e9mr8198002otf.160.1556559659685;
        Mon, 29 Apr 2019 10:40:59 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i22sm1689418otj.34.2019.04.29.10.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 10:40:58 -0700 (PDT)
Date:   Mon, 29 Apr 2019 12:40:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: mfd: axp20x: Add fallback for axp805
Message-ID: <20190429174058.GA11425@bogus>
References: <20190409160550.1086-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190409160550.1086-1-peron.clem@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 06:05:50PM +0200, Clément Péron wrote:
> axp805 is actually compatible and used with axp806 as fallback.
> But it's actually undocumented and trig a warning with checkpatch.
> 
> DT compatible string "x-powers,axp805" appears un-documented.
> 
> Add this compatible in the dt-bindings documentation.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Rob
