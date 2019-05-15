Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA73B1F4F0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 15:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfEONBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 09:01:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59444 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfEONBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:01:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 60FEE27BA8D
Subject: Re: [PATCH] platform/chrome: cros_ec_spi: Always add of_match_table
To:     Benson Leung <bleung@google.com>, Evan Green <evgreen@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20190509181750.134960-1-evgreen@chromium.org>
 <20190510214622.GA63153@google.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <6ba2e494-d9f9-0cc0-74cf-1262c57ce865@collabora.com>
Date:   Wed, 15 May 2019 15:01:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510214622.GA63153@google.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/5/19 23:46, Benson Leung wrote:
> Hi Evan,
> 
> On Thu, May 09, 2019 at 11:17:50AM -0700, Evan Green wrote:
>> The Chrome OS EC driver attaches to devices using the of_match_table
>> even when ACPI is the underlying firmware. It does this using the
>> magic PRP0001 ACPI HID, which tells ACPI to go find an OF compatible
>> string under the hood and match on that.
>>
>> The cros_ec_spi driver needs to provide the of_match_table regardless
>> of whether CONFIG_OF is enabled or not, since the table is used by
>> ACPI for PRP0001 devices.
>>
>> Signed-off-by: Evan Green <evgreen@chromium.org>
> 
> Looks good to me.
> Reviewed-by: Benson Leung <bleung@chromium.org>
> 
> I'll leave this to Enric to merge to our for-next.
> 
> Thanks,
> Benson
> 

The patch is queued to the for-next branch with the Benson rb tag for the
autobuilders to play with, if all goes well I'll add the patch for 5.3 when
current merge window closes.

Thanks,
 Enric
