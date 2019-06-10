Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A65823B765
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 16:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390863AbfFJObZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 10:31:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50930 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388996AbfFJObZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 10:31:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E78B139B07;
        Mon, 10 Jun 2019 10:31:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=oZkDF5YmmNKUTDPqazIBHbAnaEU=; b=b7uWVl
        t3qJnK7b6yAY2EuBKkH1/zP6pA5fV+qyNl2OANKdsw1SxwS4ZA4HOsI1uI8/I40Z
        CXwzq/5i0nYYkmZppQEjagBv4t7zzZrq7PkzXaprc8ayV8hJmKa7ysbZ8f0w70sM
        LedwGQCXtnj6skf7qu5Wx0Yn/BIXl4DjbDLJU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14D34139B05;
        Mon, 10 Jun 2019 10:31:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=egmImq37cU4cVanOiwF/pJUnpDte0GyseVa4bGFKY5A=; b=OhI4tFoKFJcFEaw7EVnNiL/1QNHM+9tKGxADI1avZC5HGhcgdm3wSAdVr2IH+YWiHXcyNymIWdELeHKn/HHGLMJeiDZmDikyW5vtkNY0aYzzA3Z5boDOAdUCnm7fdV7UIFI8cPkcZcP23Ppb5tlBU6j/y1yxYZC4LFS5rQS707E=
Received: from yoda.home (unknown [70.82.130.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89C86139B04;
        Mon, 10 Jun 2019 10:31:22 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 928C92DA01CE;
        Mon, 10 Jun 2019 10:31:21 -0400 (EDT)
Date:   Mon, 10 Jun 2019 10:31:21 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Gen Zhang <blackgod016574@gmail.com>
cc:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        kilobyte@angband.pl, textshell@uchuujin.de, mpatocka@redhat.com,
        daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vt: Fix a missing-check bug in con_init()
In-Reply-To: <20190610064519.GA3143@ubuntu>
Message-ID: <nycvar.YSQ.7.76.1906101030130.1558@knanqh.ubzr>
References: <20190528004529.GA12388@zhanggen-UX430UQ> <20190608160138.GA3840@zhanggen-UX430UQ> <20190608162219.GB11699@kroah.com> <nycvar.YSQ.7.76.1906082010430.1558@knanqh.ubzr> <20190610064519.GA3143@ubuntu>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 6B71D054-8B8C-11E9-9BF7-46F8B7964D18-78420484!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jun 2019, Gen Zhang wrote:

> On Sat, Jun 08, 2019 at 08:15:46PM -0400, Nicolas Pitre wrote:
> > On Sat, 8 Jun 2019, Greg KH wrote:
> > 
> > > And please provide "real" names for the
> > > labels, "fail1" and "fail2" do not tell anything here.
> > 
> > That I agree with.
> > 
> > 
> > Nicolas
> Thanks for your comments. Then am I supposed to revise the patch and
> send a v4 version?

Yes.


Nicolas
