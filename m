Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1D221C995
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 15:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfENNuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 09:50:05 -0400
Received: from verein.lst.de ([213.95.11.211]:45870 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfENNuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:50:05 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7561668BFE; Tue, 14 May 2019 15:49:43 +0200 (CEST)
Date:   Tue, 14 May 2019 15:49:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] LICENSES: Rename other to deprecated
Message-ID: <20190514134943.GA13662@lst.de>
References: <20190430105130.24500-1-hch@lst.de> <20190430105130.24500-4-hch@lst.de> <20190514102632.GA4574@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514102632.GA4574@zn.tnic>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 12:26:32PM +0200, Borislav Petkov wrote:
> This breaks scripts/spdxcheck.py, it needs below hunk. Also, should
> "dual" be added to license_dirs too?

Yes.  In fact two people already submitted patches for that before
you, just waiting for them to get picked up.
