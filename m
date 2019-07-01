Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF9384DAEB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 22:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfFTUHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 16:07:11 -0400
Received: from ms.lwn.net ([45.79.88.28]:47566 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfFTUHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:07:10 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B8D8A9B0;
        Thu, 20 Jun 2019 20:07:09 +0000 (UTC)
Date:   Thu, 20 Jun 2019 14:07:08 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andreas Ziegler <andreas.ziegler@fau.de>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: Re: [PATCH 2/6] docs: trace: add a missing blank line
Message-ID: <20190620140708.30bf0434@lwn.net>
In-Reply-To: <91f90c10c12c6a2f6fb90fc0f9115fbd8dd73848.1560883872.git.mchehab+samsung@kernel.org>
References: <a83ea390bc28784518fce772b4c961ea1c976f14.1560883872.git.mchehab+samsung@kernel.org>
        <91f90c10c12c6a2f6fb90fc0f9115fbd8dd73848.1560883872.git.mchehab+samsung@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 15:51:18 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> Sphinx expects a blank line after a literal block markup.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/trace/kprobetrace.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
> index 3d162d432a3c..caa0a8ba081e 100644
> --- a/Documentation/trace/kprobetrace.rst
> +++ b/Documentation/trace/kprobetrace.rst
> @@ -228,6 +228,7 @@ events, you need to enable it.
>  
>  Use the following command to start tracing in an interval.
>  ::
> +

Applied, thanks.

jon
