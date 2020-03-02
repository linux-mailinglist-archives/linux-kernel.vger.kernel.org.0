Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1145E176448
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 20:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCBTvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 14:51:17 -0500
Received: from ms.lwn.net ([45.79.88.28]:58354 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCBTvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:51:16 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B453B2E4;
        Mon,  2 Mar 2020 19:51:15 +0000 (UTC)
Date:   Mon, 2 Mar 2020 12:51:14 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: dev-tools: gcov: Remove a stray single-quote
Message-ID: <20200302125114.3b95d17a@lwn.net>
In-Reply-To: <20200229173515.13868-1-j.neuschaefer@gmx.net>
References: <20200229173515.13868-1-j.neuschaefer@gmx.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Feb 2020 18:35:14 +0100
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/dev-tools/gcov.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/dev-tools/gcov.rst b/Documentation/dev-tools/gcov.rst
> index 46aae52a41d0..7bd013596217 100644
> --- a/Documentation/dev-tools/gcov.rst
> +++ b/Documentation/dev-tools/gcov.rst
> @@ -203,7 +203,7 @@ Cause
>      may not correctly copy files from sysfs.
> 
>  Solution
> -    Use ``cat``' to read ``.gcda`` files and ``cp -d`` to copy links.
> +    Use ``cat`` to read ``.gcda`` files and ``cp -d`` to copy links.
>      Alternatively use the mechanism shown in Appendix B.

Applied, thanks.

jon
