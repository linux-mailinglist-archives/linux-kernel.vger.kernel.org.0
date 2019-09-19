Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5022B7AB6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 15:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390324AbfISNoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 09:44:01 -0400
Received: from first.geanix.com ([116.203.34.67]:42344 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387417AbfISNoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:44:01 -0400
Received: from [192.168.8.20] (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id C2CAD64891;
        Thu, 19 Sep 2019 13:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568900636; bh=IQmTBlSmfjmmHffrMqbWC875jDk1mYznbnYK/ryoUmw=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To;
        b=dG2dXJoakXB737JIyjv+dOTuRqrVroPoVIsTux9BAdHWn+smyWMlCYl56C4a2wBnM
         ZswbfvjYyV4R90Yy0N8cfvC7L1iGXTUxE0l+iM2R0bvY0nvHVHVZqMcc9JJaaPQ7pg
         BUnt6DmDZf8peshFUJThizGhT2DERsdEeU2qH/r+LXLVJMAgtpCZEwzQVdFOwM6HN9
         1ij6m4tI4Mo7g6I504k7nAn6aElvkLMk1/RVg9cHKLLA72V6kMGudOt6Y7/rvqM2mm
         THd4dEaGzTlgpcNza8JEXcwponWdzUKHQHVmiCBnhKBqV7LyhA3YfTJDJ+r2wEwnKN
         r4pZPPk1n1A2g==
Subject: Re: [BUG] tty: n_gsm: possible circular locking dependency detected
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean@geanix.com>,
        Esben Haabendal <esben@geanix.com>
References: <4b2455c0-25ba-0187-6df6-c63b4ccc6a6e@geanix.com>
Message-ID: <fd71a56a-2f5f-757f-7011-b5a618ff6951@geanix.com>
Date:   Thu, 19 Sep 2019 15:43:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <4b2455c0-25ba-0187-6df6-c63b4ccc6a6e@geanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on b8b5098bc1bc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2019 15.27, Martin Hundebøll wrote:
> But we haven't been able to reproduce locally.

Scratch that. It's reliably reproduced by sending/saturating the uart 
with outgoing data.

// Martin
