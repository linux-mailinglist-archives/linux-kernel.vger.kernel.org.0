Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 616E959E73
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 17:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfF1PKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 11:10:23 -0400
Received: from ms.lwn.net ([45.79.88.28]:35104 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfF1PKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:10:23 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A1B4D5A0;
        Fri, 28 Jun 2019 15:10:22 +0000 (UTC)
Date:   Fri, 28 Jun 2019 09:10:21 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: format kernel-parameters -- as code
Message-ID: <20190628091021.457d0301@lwn.net>
In-Reply-To: <20190627135938.3722-1-steve@sk2.org>
References: <20190627135938.3722-1-steve@sk2.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019 15:59:38 +0200
Stephen Kitt <steve@sk2.org> wrote:

> The current ReStructuredText formatting results in "--", used to
> indicate the end of the kernel command-line parameters, appearing as
> an en-dash instead of two hyphens; this patch formats them as code,
> "``--``", as done elsewhere in the documentation.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>

A worthy fix, I've applied it.  This seems like the sort of annoyance that
will bite us over and over, though.  We might want to find a more
comprehensive way to turn this behavior off.

Thanks,

jon
