Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 649C5F6EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 13:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbfD3Lxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 07:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730565AbfD3Lxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:53:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 799382075E;
        Tue, 30 Apr 2019 11:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556625222;
        bh=ulh/dOBZo/I8x2ReyMQ0GnSjIUgyQejot7EHRcKeUPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k8anD+6xoq+foqxxEoj7DEIeLMQtFJC8vp0l6BEn2x33ufPyXHK8Ca32LeA69VJgp
         udy2zZnEiQaZnhtCpcUyiZZlIorRgSdGfNI9W94NztV1ywfVhDFrIH/d92zjR1hJ+d
         MB+m6s1+kgpXC7z45xJtgSRbOcqaEmWBwYtbN7I8=
Date:   Tue, 30 Apr 2019 13:41:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: clarify other licenses in LICENSES/
Message-ID: <20190430114134.GA17027@kroah.com>
References: <20190430105130.24500-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430105130.24500-1-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 06:51:27AM -0400, Christoph Hellwig wrote:
> Hi all,
> 
> this series splits the others category into dual or deprecated,
> and also fixes up some other minor bits in the documentation for
> these non-preferred licenses.

Looks good to me, thanks for doing this!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
