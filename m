Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B285F94A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 16:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfKLPqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 10:46:39 -0500
Received: from ms.lwn.net ([45.79.88.28]:41614 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfKLPqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:46:39 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 067735A0;
        Tue, 12 Nov 2019 15:46:36 +0000 (UTC)
Date:   Tue, 12 Nov 2019 08:46:34 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Trilok Soni <tsoni@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] Documentation/process: Add AMD contact for embargoed
 hardware issues
Message-ID: <20191112084634.75b4cf77@lwn.net>
In-Reply-To: <c1062e44a8784747e4834d28de6f54c30ae95058.1573500877.git.thomas.lendacky@amd.com>
References: <c1062e44a8784747e4834d28de6f54c30ae95058.1573500877.git.thomas.lendacky@amd.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019 13:34:37 -0600
Tom Lendacky <thomas.lendacky@amd.com> wrote:

> Add myself as the AMD ambassador to the embargoed hardware issues
> document.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  Documentation/process/embargoed-hardware-issues.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
> index a3c3349046c4..799580acc8de 100644
> --- a/Documentation/process/embargoed-hardware-issues.rst
> +++ b/Documentation/process/embargoed-hardware-issues.rst
> @@ -240,7 +240,7 @@ an involved disclosed party. The current ambassadors list:
>  
>    ============= ========================================================
>    ARM
> -  AMD
> +  AMD		Tom Lendacky <tom.lendacky@amd.com>

I've applied this, thanks.

jon
