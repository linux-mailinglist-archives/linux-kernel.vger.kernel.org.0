Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C652C46B35
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 22:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfFNUok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 16:44:40 -0400
Received: from ms.lwn.net ([45.79.88.28]:54268 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbfFNUok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:44:40 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A74AE740;
        Fri, 14 Jun 2019 20:44:39 +0000 (UTC)
Date:   Fri, 14 Jun 2019 14:44:38 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linuxppc-dev@lists.ozlabs.org, arnd@arndb.de,
        bhupesh.linux@gmail.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RESEND PATCH] Documentation/stackprotector: powerpc supports
 stack protector
Message-ID: <20190614144438.211b4dd0@lwn.net>
In-Reply-To: <1560161019-3895-1-git-send-email-bhsharma@redhat.com>
References: <1560161019-3895-1-git-send-email-bhsharma@redhat.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2019 15:33:39 +0530
Bhupesh Sharma <bhsharma@redhat.com> wrote:

> powerpc architecture (both 64-bit and 32-bit) supports stack protector
> mechanism since some time now [see commit 06ec27aea9fc ("powerpc/64:
> add stack protector support")].
> 
> Update stackprotector arch support documentation to reflect the same.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
> Resend, this time Cc'ing Jonathan and doc-list.

Applied, thanks.

jon
