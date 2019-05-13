Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B40571B5B4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 14:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfEMMTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 08:19:33 -0400
Received: from mail.monom.org ([188.138.9.77]:37292 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727414AbfEMMTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:19:33 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 212AE50065D;
        Mon, 13 May 2019 14:19:31 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from [127.0.0.1] (mail.monom.org [188.138.9.77])
        by mail.monom.org (Postfix) with ESMTPSA id D9E6A5003CD;
        Mon, 13 May 2019 14:19:30 +0200 (CEST)
Subject: Re: [PATCH] Fix a lockup in wait_for_completion() and friends
From:   Daniel Wagner <wagi@monom.org>
To:     minyard@acm.org, linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Corey Minyard <cminyard@mvista.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20190508202759.13842-1-minyard@acm.org>
 <e30aebd4-2d7e-f892-b31a-66ff2c7e474d@monom.org>
Message-ID: <2b918cd0-b01f-3417-6ba0-d4bb12cfd3c5@monom.org>
Date:   Mon, 13 May 2019 14:19:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e30aebd4-2d7e-f892-b31a-66ff2c7e474d@monom.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Added Peter and lkml to the CC since this is mainline and not -rt only.

Argh, forget it. was late to the party and missed the discussion.
