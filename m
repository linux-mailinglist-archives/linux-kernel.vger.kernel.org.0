Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64590D44D8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 18:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfJKQAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 12:00:19 -0400
Received: from ms.lwn.net ([45.79.88.28]:39258 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfJKQAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:00:19 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 194AC2E6;
        Fri, 11 Oct 2019 16:00:19 +0000 (UTC)
Date:   Fri, 11 Oct 2019 10:00:18 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     Micah Morton <mortonm@chromium.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [TYPO] SafeSetID.rst: Remove spurious '???' characters
Message-ID: <20191011100018.0e9fff37@lwn.net>
In-Reply-To: <alpine.DEB.2.21.99999.352.1910102033050.30236@trent.utfs.org>
References: <alpine.DEB.2.21.99999.352.1910102033050.30236@trent.utfs.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 20:36:16 -0700 (PDT)
Christian Kujau <lists@nerdbynature.de> wrote:

> While reading SafeSetID.rst I stumbled across those things. This patch 
> removes these spurious '???' characters.
>     
> Signed-off-by: Christian Kujau <lists@nerdbynature.de>

I've applied this, thanks.  I did take the liberty of rewriting the
changelog to adhere to normal standards:

Author: Christian Kujau <lists@nerdbynature.de>
Date:   Thu Oct 10 20:36:16 2019 -0700

    docs: SafeSetID.rst: Remove spurious '???' characters
    
    It appears that some smart quotes were changed to "???" by even smarter
    software; change them to the dumb but legible variety.
    
    Signed-off-by: Christian Kujau <lists@nerdbynature.de>
    Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Thanks,

jon
