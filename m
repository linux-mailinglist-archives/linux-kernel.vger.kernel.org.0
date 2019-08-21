Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBBBD98689
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 23:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbfHUVVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 17:21:14 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40273 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfHUVVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 17:21:13 -0400
Received: by mail-oi1-f193.google.com with SMTP id h21so2745298oie.7;
        Wed, 21 Aug 2019 14:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tjmcHkDDb0u7HTtUUq1ahiqlmHmFStmFZVfSaL4Jko0=;
        b=V6SDqcyHbEjOwJYOM4M7DNCOXsmfEa1XQZzh9Ifgk+bgQlnpFcfsKmT2C/toBof9Q4
         rDm4z9m+BNR+kPVMOK/+mqmoxDDWhD6e4jcaMP4Rm8qfctCJvOJ9SdGEHdM33K4/E48I
         8D9GCBwsR6ysNyaDLawdiUtidbFDKhU54SFuLn72Kh+exTIa/3lze9NkOdllnzrAV032
         twKC8fJ+ZmV5xVZBwkxdxFs+W3uqUlRcn683mcrvlYL1uW7OzZE3omtd8HAqPdlCNNau
         R1UPpY8w/yqalry5tazzr+XajpQiXZmcClYZzO0YZA7ycTKaB+J1hipDJagrvLWgTCNF
         1MIg==
X-Gm-Message-State: APjAAAUxjNi5MLt7j2OF6Br6OyCuECUaeUWtNgmdLCU5dFvggdiTiU1b
        ehPnQ9SU8TLeLPWSSHjovg==
X-Google-Smtp-Source: APXvYqwY0oaxVhQ5XoomnMvx3BMqoxapSg2tNzSNujp0i3hlBT/KHg4HLn/J5iH5dzScpADXFwsthA==
X-Received: by 2002:aca:37c5:: with SMTP id e188mr1438662oia.66.1566422472753;
        Wed, 21 Aug 2019 14:21:12 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f21sm8423504otq.7.2019.08.21.14.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 14:21:12 -0700 (PDT)
Date:   Wed, 21 Aug 2019 16:21:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Joe Burmeister <joe.burmeister@devtank.co.uk>
Cc:     Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add optional chip erase functionality to AT25 EEPROM
 driver.
Message-ID: <20190821212111.GA26116@bogus>
References: <20190809125358.24440-1-joe.burmeister@devtank.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809125358.24440-1-joe.burmeister@devtank.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 01:53:55PM +0100, Joe Burmeister wrote:
> Many, though not all, AT25s have an instruction for chip erase.
> If there is one in the datasheet, it can be added to device tree.
> Erase can then be done in userspace via the sysfs API with a new
> "erase" device attribute. This matches the eeprom_93xx46 driver's
> "erase".
> 
> Signed-off-by: Joe Burmeister <joe.burmeister@devtank.co.uk>
> ---
>  .../devicetree/bindings/eeprom/at25.txt       |  2 +

Please split bindings to a separate patch.

>  drivers/misc/eeprom/at25.c                    | 83 ++++++++++++++++++-
>  2 files changed, 82 insertions(+), 3 deletions(-)
