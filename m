Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C342A1997BD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 15:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbgCaNoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 09:44:05 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34217 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730366AbgCaNoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:44:04 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02VDi0jb024676;
        Tue, 31 Mar 2020 15:44:00 +0200
Date:   Tue, 31 Mar 2020 15:44:00 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Backport dependencies helper
Message-ID: <20200331134400.GA24671@1wt.eu>
References: <20200331123217.GM4189@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331123217.GM4189@sasha-vm>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

On Tue, Mar 31, 2020 at 08:32:17AM -0400, Sasha Levin wrote:
> Each
> directory represents a kernel version which we'll call K, and each file
> inside that directory is named after an upstream commit we'll call C,
> and it's content are the list of commits one would need to apply on top
> of kernel K to "reach" commit C.

That's very interesting! I still have nightmare-like memories or
complete week-ends spent trying to address this using heuristics
when I was maintaining 2.6.32 and 3.10. However how do you produce
these ? Is this related to the stable-deps utility in your stable-tools
repository ?

Thanks,
Willy
