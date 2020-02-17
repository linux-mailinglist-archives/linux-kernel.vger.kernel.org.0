Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5AD31612AF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 14:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgBQNIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 08:08:32 -0500
Received: from verein.lst.de ([213.95.11.211]:33694 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgBQNIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:08:32 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0815468B05; Mon, 17 Feb 2020 14:08:29 +0100 (CET)
Date:   Mon, 17 Feb 2020 14:08:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Anatoly Pugachev <matorola@gmail.com>, Pat Gefre <pfg@sgi.com>,
        Christoph Hellwig <hch@lst.de>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-doc@vger.kernel.org, Joe Perches <joe@perches.com>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty/serial: cleanup after ioc*_serial driver removal
Message-ID: <20200217130828.GB26781@lst.de>
References: <20200217081558.10266-1-lukas.bulwahn@gmail.com> <CADxRZqwGBi=4A224mG0cPgONdNitnvi3LFD_KQckxdYSXzgBGg@mail.gmail.com> <alpine.DEB.2.21.2002170950390.11007@felia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2002170950390.11007@felia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:09:45AM +0100, Lukas Bulwahn wrote:
> The description is about situations on very outdated kernel versions, so 
> the whole page needs a general update.

While the file doesn't seem all that useful, I think removing or updating
it should probably be a separate patch.
