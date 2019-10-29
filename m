Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA86E85D3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 11:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfJ2Kht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 06:37:49 -0400
Received: from ms.lwn.net ([45.79.88.28]:44268 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfJ2Khs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 06:37:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2D53A4FA;
        Tue, 29 Oct 2019 10:37:46 +0000 (UTC)
Date:   Tue, 29 Oct 2019 04:37:43 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andre Azevedo <andre.azevedo@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH] Documentation/scheduler: fix links in sched-stats
Message-ID: <20191029043743.793052a7@lwn.net>
In-Reply-To: <20191026195554.GA30903@aap-ubuntu>
References: <20191026195554.GA30903@aap-ubuntu>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Oct 2019 12:55:54 -0700
Andre Azevedo <andre.azevedo@gmail.com> wrote:

> The rain.com domain recently moved to pdxhosts.com, making the scheduler
> documentation point to broken links. Fix the links in the scheduler
> documentation.
> 
> CC: Rick Lindsley <ricklind@linux.vnet.ibm.com>
> Signed-off-by: Andre Azevedo <andre.azevedo@gmail.com>

Working links are better than dead ones, so I've applied this.  It still
appears to be rather old stuff, though - 2.6.x was a while ago at this
point.  It would sure be nice to get this information current and in
Documentation/ directly at some point ... 

Thanks,

jon
