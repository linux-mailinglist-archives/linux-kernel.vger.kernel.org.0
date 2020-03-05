Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B60EA179D93
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 02:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgCEBqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 20:46:09 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:56543 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725810AbgCEBqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:46:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TrhPXjp_1583372756;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TrhPXjp_1583372756)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Mar 2020 09:45:56 +0800
Subject: Re: [PATCH v2 04/12] docs: dt: convert booting-without-of.txt to ReST
 format
To:     Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>, devicetree@vger.kernel.org
References: <cover.1583135507.git.mchehab+huawei@kernel.org>
 <b7c582284fbca91a7431ff14689ab1be2c6fc410.1583135507.git.mchehab+huawei@kernel.org>
 <CAL_Jsq+qEA16aGAaVnwX6QAPGnCWqnx_6WNuRb0erVAA3rvYSA@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <b3759bbc-0366-d31b-6ef6-6208ba0bae67@linux.alibaba.com>
Date:   Thu, 5 Mar 2020 09:45:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+qEA16aGAaVnwX6QAPGnCWqnx_6WNuRb0erVAA3rvYSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/3/5 上午2:25, Rob Herring 写道:
> Let's skip this doc. It's been on my todo to remove it. It's pretty
> stale and 15 years old. Much of this document is now covered by what's
> in the DT spec. There's a few pieces that aren't which we need to find
> new homes for.
> 

Happy to see a old doc getting update! :)
