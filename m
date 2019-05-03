Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1E3612DD6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 14:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfECMlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 08:41:09 -0400
Received: from ms.lwn.net ([45.79.88.28]:48064 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbfECMlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 08:41:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B0F3D7DC;
        Fri,  3 May 2019 12:41:07 +0000 (UTC)
Date:   Fri, 3 May 2019 06:41:05 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/documentation-file-ref-check: detect broken
 :doc:`foo`
Message-ID: <20190503064105.763ab1e9@lwn.net>
In-Reply-To: <a24b46d49121c4f3d90f55acc20c8efb6b0a9280.1556123129.git.mchehab+samsung@kernel.org>
References: <a24b46d49121c4f3d90f55acc20c8efb6b0a9280.1556123129.git.mchehab+samsung@kernel.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019 13:25:33 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> As we keep migrating documents to ReST, we're starting to see
> more of such tags.
> 
> Right now, all such tags are pointing to a documentation file,
> but regressions may be introduced.
> 
> So, add a check for such kind of issues as well.

Applied, thanks.

jon
