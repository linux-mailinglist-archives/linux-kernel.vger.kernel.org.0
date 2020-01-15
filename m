Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75D7513C759
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 16:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgAOPWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 10:22:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgAOPWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:22:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 309C32053B;
        Wed, 15 Jan 2020 15:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579101738;
        bh=xQmCyFQKagD5zDRlX3Qlfs8hMu8+HZwNUQzGdVyqi5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fVw5yj+U1NPrGHrcpdvUVYorEbTy7dsunxncXsx5tOnJfYg8xDWzdUYV5T3JpRMj3
         kfhnPv44rNtofwxqnyHr36yJhL8caHMOIOVaXUPv4gIDfGdiFfXjVNr88CAT66S/Cw
         PLEbNEbRTfxGN9Yv+jMz+F9EOeYQuNQhYpTPRa5Y=
Date:   Wed, 15 Jan 2020 16:22:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Julian Stecklina <julian.stecklina@cyberus-technology.de>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhiyuan.lv@intel.com, hang.yuan@intel.com,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [RFC PATCH 4/4] drm/i915/gvt: move public gvt headers out into
 global include
Message-ID: <20200115152215.GA3830321@kroah.com>
References: <4079ce7c26a2d2a3c7e0828ed1ea6008d6e2c805.camel@cyberus-technology.de>
 <20200109171357.115936-1-julian.stecklina@cyberus-technology.de>
 <20200109171357.115936-5-julian.stecklina@cyberus-technology.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109171357.115936-5-julian.stecklina@cyberus-technology.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 07:13:57PM +0200, Julian Stecklina wrote:
> Now that the GVT interface to hypervisors does not depend on i915/GVT
> internals anymore, we can move the headers to the global include/.
> 
> This makes out-of-tree modules for hypervisor integration possible.

What kind of out-of-tree modules do you need/want for this?  And why do
they somehow have to be out of the tree?  We want them in the tree, and
so should you, as it will save you time and money if they are.

Also, as Christoph said, adding exports for functions that are not used
by anything within the kernel tree itself is not ok, that's not how we
work.

thanks,

greg k-h
