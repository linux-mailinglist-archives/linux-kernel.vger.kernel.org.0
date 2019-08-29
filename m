Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12CFDA1B97
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 15:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfH2Nhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 09:37:43 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:35770 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfH2Nhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:37:42 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i3KcH-000130-QZ; Thu, 29 Aug 2019 15:37:33 +0200
Message-ID: <696734afb27182d7a1a9218dd3cfa01f47a76093.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Rewrite host RNG driver.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexander Neville <dark@volatile.bz>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 29 Aug 2019 15:37:32 +0200
In-Reply-To: <20190828204609.02a7ff70@TheDarkness>
References: <20190828204609.02a7ff70@TheDarkness>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-28 at 21:44 -0400, Alexander Neville wrote:
> The old driver had a bug that would cause it to outright stop working if
> the host's /dev/random were to block. Instead of trying to track down
> the cause of said bug, rewriting it from scratch turned out to be a much
> better option as it came with a few benefits:
> 
>  - The new driver properly registers itself as an hardware RNG.
> 
>  - The code is simpler and therefore easier to maintain.
> 
>  - It serves as a minimal example of writing a hardware RNG driver.
> 
> I also edited the Kconfig symbol to bring it up to more modern
> standards.

I realize that it's still easier to use, but theoretically you could
just use the virtio implementation, and use that driver with a suitable
small vhost device implementation. :-)

johannes

