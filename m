Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8B137021
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 11:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfFFJjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 05:39:53 -0400
Received: from foss.arm.com ([217.140.101.70]:43958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbfFFJjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:39:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B1DB341;
        Thu,  6 Jun 2019 02:39:53 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8BBF3F690;
        Thu,  6 Jun 2019 02:39:50 -0700 (PDT)
Date:   Thu, 6 Jun 2019 10:39:46 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "George G. Davis" <george_davis@mentor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Jiri Kosina <trivial@kernel.org>,
        Julien Grall <julien.grall@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] ARM64: trivial: s/TIF_SECOMP/TIF_SECCOMP/ comment
 typo fix
Message-ID: <20190606093946.GA6795@fuggles.cambridge.arm.com>
References: <1559766612-12178-1-git-send-email-george_davis@mentor.com>
 <201906051503.010FF2AF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201906051503.010FF2AF@keescook>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 03:04:06PM -0700, Kees Cook wrote:
> On Wed, Jun 05, 2019 at 04:30:09PM -0400, George G. Davis wrote:
> > Fix a s/TIF_SECOMP/TIF_SECCOMP/ comment typo
> > 
> > Cc: Jiri Kosina <trivial@kernel.org>
> > Signed-off-by: George G. Davis <george_davis@mentor.com>
> 
> Sneaky missing "C"! :)
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

I've already got a few arm64 patches for -rc4, so I'll include this one
in my pull as it's harmless.

Cheers,

Will
