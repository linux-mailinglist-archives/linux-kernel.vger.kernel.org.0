Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5EB312DB7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 14:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfECMe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 08:34:58 -0400
Received: from ms.lwn.net ([45.79.88.28]:47980 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfECMe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 08:34:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 490267DE;
        Fri,  3 May 2019 12:34:55 +0000 (UTC)
Date:   Fri, 3 May 2019 06:34:53 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: clarify other licenses in LICENSES/
Message-ID: <20190503063453.1378ff99@lwn.net>
In-Reply-To: <20190430114134.GA17027@kroah.com>
References: <20190430105130.24500-1-hch@lst.de>
        <20190430114134.GA17027@kroah.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2019 13:41:34 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Tue, Apr 30, 2019 at 06:51:27AM -0400, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series splits the others category into dual or deprecated,
> > and also fixes up some other minor bits in the documentation for
> > these non-preferred licenses.  
> 
> Looks good to me, thanks for doing this!
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I've applied the set, thanks.

jon
