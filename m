Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF3A213FA0A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 20:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbgAPTxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 14:53:35 -0500
Received: from ms.lwn.net ([45.79.88.28]:44600 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729397AbgAPTxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 14:53:34 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1A06B1E5;
        Thu, 16 Jan 2020 19:53:34 +0000 (UTC)
Date:   Thu, 16 Jan 2020 12:53:33 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, kernel-team@android.com,
        Mark Brown <broonie@kernel.org>, Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH] Documentation: Call out example SYM_FUNC_* usage as
 x86-specific
Message-ID: <20200116125333.5de68e48@lwn.net>
In-Reply-To: <20200115184305.1187-1-will@kernel.org>
References: <20200115184305.1187-1-will@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2020 18:43:05 +0000
Will Deacon <will@kernel.org> wrote:

> The example given in asm-annotations.rst to describe the constraints that
> a function should meet in order to be annotated with a SYM_FUNC_* macro
> is x86-specific, and not necessarily applicable to architectures using
> branch-and-link style calling conventions such as arm64.
> 
> Tweak the example text to call out the x86-specific text.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---

Makes sense to me, applied, thanks.

jon
