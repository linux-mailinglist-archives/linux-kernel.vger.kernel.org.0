Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 880A1140F4C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 17:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgAQQuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 11:50:08 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:33507 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgAQQuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:50:08 -0500
X-Originating-IP: 109.204.130.2
Received: from kurenai.i.gensoukyou.net (unknown [109.204.130.2])
        (Authenticated sender: oranenj@gensoukyou.net)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E45B91BF210
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 16:50:06 +0000 (UTC)
In-Reply-To: <4efb35fb-d2ee-49e7-8c7d-e8bab315ca60@iki.fi>
To:     linux-kernel@vger.kernel.org
From:   Jarkko Oranen <oranenj@iki.fi>
Subject: Re: (Solved) Linux router responds to any ARP query when iproute2
 xfrm policies are configured for an IPSec tunnel. What's going on?
Message-ID: <33990f03-fdaa-34d5-9a54-4c0b2ced7c75@iki.fi>
Date:   Fri, 17 Jan 2020 18:50:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,



hopefully I got the In-Reply-To header right.



Turns out that while I thought I had disabled charon's fake-arp plugin, 
it was silently loading configuration from /etc/strongswan/charon I 
didn't expect it to load and despite the plugin being enabled, it made 
no indication that this is the case. I'll leave this here for Google in 
case someone else stubs their toe on this.



Sorry for the noise.


--

Jarkko
