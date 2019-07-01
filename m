Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0A7612DCA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 14:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfECMjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 08:39:40 -0400
Received: from ms.lwn.net ([45.79.88.28]:48050 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbfECMjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 08:39:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5B3147DE;
        Fri,  3 May 2019 12:39:39 +0000 (UTC)
Date:   Fri, 3 May 2019 06:39:37 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/documentation-file-ref-check: don't parse Next/
 dir
Message-ID: <20190503063937.590a64c3@lwn.net>
In-Reply-To: <64012d057b5cf2b75192fb75ef5d2547254ccf06.1555933320.git.mchehab+samsung@kernel.org>
References: <64012d057b5cf2b75192fb75ef5d2547254ccf06.1555933320.git.mchehab+samsung@kernel.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2019 08:42:02 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> If one tries to run this script under linux-next, it would
> hit lots of false-positives, due to the tree merges that
> are stored under the Next/ directory.
> 
> So, add a logic to ignore it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Applied, thanks.

jon
