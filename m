Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50447141B6A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jan 2020 04:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbgASDNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 22:13:49 -0500
Received: from ns3.fnarfbargle.com ([103.4.19.87]:60514 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgASDNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:13:48 -0500
Received: from [10.8.0.1] (helo=srv.home ident=heh22038)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1it122-0001Ee-6P; Sun, 19 Jan 2020 11:13:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=AihWplvJtdbUp+6jewTLVn4+o2sVAzvWGPw1MhIl0Ok=;
        b=emjlcVjXGHq+T9x2P5kXJeM4eoruY8t0bErlasqfnyWmcTrXj9UjfTWnppWEqjvO+1kj1K2Y7RmXdbj6diLcFNDIBZd2i4wNRAkncYOBMmPO5/dEePzw5fMAWa6vSeszthAqSFX0b05p1xufgRODOaKpK0QFFJrZ+Gi/OOCAres=;
Subject: Re: [PATCH v2 0/5] hwmon: k10temp driver improvements
To:     Guenter Roeck <linux@roeck-us.net>
References: <20200118172615.26329-1-linux@roeck-us.net>
 <CANVEwpbgi5sUdBTyo330oCZ1T-cD+DoBJWrE9JbXw-DvYTiBvw@mail.gmail.com>
 <7345a801-6e9d-b85f-1a8a-72ee89cc0330@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
From:   Brad Campbell <lists2009@fnarfbargle.com>
Message-ID: <4996ea33-7fe2-59c7-32b2-a7bd09d42080@fnarfbargle.com>
Date:   Sun, 19 Jan 2020 11:13:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7345a801-6e9d-b85f-1a8a-72ee89cc0330@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/1/20 8:48 am, Guenter Roeck wrote:
> Everyone: I'll be happy to add Tested-by: tags with your name and e-mail
> address to the series, but you'll have to send it to me. I appreciate
> all your testing and would like to acknowledge it, but I can not add
> Tested-by: tags (or any other tags, for that matter) on my own.
> 
> Thanks,
> Guenter
> 

Tested-by: Brad Campbell <lists2009@fnarfbargle.com>

