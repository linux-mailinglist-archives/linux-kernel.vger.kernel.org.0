Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16606173841
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 14:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgB1N0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 08:26:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgB1N0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:26:40 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 997F22469D;
        Fri, 28 Feb 2020 13:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582896399;
        bh=z5dwAWLcjLjo0C71mnZQrP9hXaDFY2g2woModyNi4c0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vXQT6sCm/cOR/vLkA3/epVyaK+gc/odiPnJpy8D+WWU8SCl7cMjkWBs3XHpc3upNc
         xCz21kzRVtCdp88oK3Khn5r3hMziR4mkrq07D9UCd2vjGk3XstZs+hdaBPLSRlxNzf
         aFOUTw3b2bd9xE27AfNdVu5bxA/4+C71h+M4MU2A=
Date:   Fri, 28 Feb 2020 22:26:35 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: bootconfig: Update boot configuration
 documentation
Message-Id: <20200228222635.96b258bedd2e68141b8a45c9@kernel.org>
In-Reply-To: <57b79bdd-36f1-c8c3-e1d3-7d21db47a8f3@web.de>
References: <158287861133.18632.12035327305997207220.stgit@devnote2>
        <158287862131.18632.11822701514141299400.stgit@devnote2>
        <57b79bdd-36f1-c8c3-e1d3-7d21db47a8f3@web.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 11:00:43 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> …
> > +++ b/Documentation/admin-guide/bootconfig.rst
> …
> > +… All sub-keys under "kernel" root key are passed as a part of
> > +kernel command line [1]_, and ones under "init" root key are passed as a part
> > +of init command line. …
> 
> Can an enumeration be clearer for this information?
> 
> Will the distinction become more interesting for well-known keys?

Your question becomes more meaningless... If you have any such concern,
you can write a patch on it for a contribution. Yes, you can!

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
