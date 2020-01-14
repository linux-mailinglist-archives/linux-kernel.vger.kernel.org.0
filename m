Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1FC513AD10
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 16:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgANPGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 10:06:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgANPGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:06:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47311206D5;
        Tue, 14 Jan 2020 15:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579014364;
        bh=hrgX1mwFA1hO9cXQwtcHBBFuCTcWaR2255QdVI4Rx8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cewPS/kP0cj2h5XJ8K9A1Oi6v8931IUE1i5JMQ/gkhV8kA3hn0ObOWw2XeodbkCb5
         ZG8zYbMG4XSNasMHsLe0kycHUxKqWghMl0Y1U+ojmbkimMslR8q4lVILVwUm/YsCSb
         b9RrEesMEkP8qsR0k/dNF8r6wixNDfElgK30DxLU=
Date:   Tue, 14 Jan 2020 16:06:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     rafael@kernel.org, lduncan@suse.com, cleech@redhat.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        open-iscsi@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 0/3] drivers base: transport component error propagation
Message-ID: <20200114150602.GC1975425@kroah.com>
References: <20200106185817.640331-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106185817.640331-1-krisman@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 01:58:14PM -0500, Gabriel Krisman Bertazi wrote:
> Hi,
> 
> This small series improves error propagation on the transport component
> to prevent an inconsistent state in the iscsi module.  The bug that
> motivated this patch results in a hanging iscsi connection that cannot
> be used or removed by userspace, since the session is in an inconsistent
> state.
> 
> That said, I tested it using the TCP iscsi transport (and forcing errors
> on the triggered function), which doesn't require a particularly complex
> container structure, so it is not the best test for finding corner cases
> on the atomic attribute_container_device trigger version.
> 
> Please let me know what you think.

Looks sane, feel free to take the first two patches through what ever
tree iscsi patches go through.

thanks,

greg k-h
