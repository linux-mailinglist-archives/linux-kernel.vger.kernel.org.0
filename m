Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 114CEECE1A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2019 11:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfKBKpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Nov 2019 06:45:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfKBKpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 06:45:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22A8B20679;
        Sat,  2 Nov 2019 10:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572691521;
        bh=LfFFd/nJYfHJFsqVGsEoQtR60v9p4ap2qOO4J0o7kLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G66wXHhpvRgZqtVsKX7CBKUn66nwIpUs1nent6PqdSoYQ+PurnPvwsMBfiq+ynUkh
         eaUy8v2Q7jPraueqfRixX1I0NFiAEUYTnv5O+NLmKWpJNbLgu1hn/imonsmtO2mun6
         arAlOOnxsY7jb1pbQfLaP2sT5l9b/LToIzcJql/Y=
Date:   Sat, 2 Nov 2019 11:45:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, julia.lawall@lip6.fr,
        m.tretter@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: allegreo-dvt: fix warning of comparison of 0/1
 to bool
Message-ID: <20191102104519.GC184849@kroah.com>
References: <20191102004213.24909-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102004213.24909-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2019 at 12:42:13AM +0000, Jules Irenge wrote:
> Fix warning of comparison of 0/1 to bool variable.

Again, this isn't a "warning", but just a coccinelle-noticed
recommendation.

thanks,

greg k-h
