Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86D671D130
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 23:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfENVTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 17:19:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbfENVTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 17:19:43 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0503720873;
        Tue, 14 May 2019 21:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557868783;
        bh=gd/pnIADB9mnwVxFskwGr4PQpavxFmsa/Jk1ovMRRKE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0KPtgXBTjx+yxCOJRLdK3ANmNHcVOXoTW0PMbaSNhVwIY58b/mYVCuS1E3gE/DzYK
         G/uVC89drvDek5hvTDXKgdC8b/+bMQwJTArsj2R3VHtu0RU3qPgqE8XEtV/mXtRfve
         7EpXicwvGUWjn+Y7wQr18No7iGnqvlNpa0DLoPCc=
Date:   Tue, 14 May 2019 14:19:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 1/3] mm/vmap: keep track of free blocks for vmap
 allocation
Message-Id: <20190514141942.23271725e5d1b8477a44f102@linux-foundation.org>
In-Reply-To: <20190406183508.25273-2-urezki@gmail.com>
References: <20190406183508.25273-1-urezki@gmail.com>
        <20190406183508.25273-2-urezki@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An earlier version of this patch was accused of crashing the kernel:

https://lists.01.org/pipermail/lkp/2019-April/010004.html

does the v4 series address this?
