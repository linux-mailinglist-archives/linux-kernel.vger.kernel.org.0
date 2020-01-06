Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5261913156C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 16:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgAFPv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 10:51:27 -0500
Received: from gentwo.org ([3.19.106.255]:48330 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgAFPv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:51:27 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 8092B3F875; Mon,  6 Jan 2020 15:51:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 7F9463E89B;
        Mon,  6 Jan 2020 15:51:26 +0000 (UTC)
Date:   Mon, 6 Jan 2020 15:51:26 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
In-Reply-To: <20200106115733.GH12699@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.2001061550270.23163@www.lameter.com>
References: <20191126165420.GL20912@dhcp22.suse.cz> <alpine.DEB.2.21.1911271535560.16935@www.lameter.com> <20191127162400.GT20912@dhcp22.suse.cz> <alpine.DEB.2.21.1911271625110.17727@www.lameter.com> <20191127174317.GD26807@dhcp22.suse.cz>
 <20191204132812.GF25242@dhcp22.suse.cz> <alpine.DEB.2.21.1912041524290.18825@www.lameter.com> <20191204153225.GM25242@dhcp22.suse.cz> <alpine.DEB.2.21.1912041652410.29709@www.lameter.com> <20191204173224.GN25242@dhcp22.suse.cz>
 <20200106115733.GH12699@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2020, Michal Hocko wrote:

> On Wed 04-12-19 18:32:24, Michal Hocko wrote:
> > [Cc akpm - the email thread starts
> > http://lkml.kernel.org/r/20191126121901.GE20912@dhcp22.suse.cz]
>
> ping.

There does not seem to be much of an interest in the patch?

