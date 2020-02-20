Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3CB9165DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 13:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgBTMnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 07:43:49 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:39981 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbgBTMnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:43:49 -0500
Subject: Re: w83627ehf crash in 5.6.0-rc2-00055-gca7e1fd1026c
To:     "Dr. David Alan Gilbert" <linux@treblig.org>
Cc:     linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Chen Zhou <chenzhou10@huawei.com>
References: <434212bb-4eb9-7366-3255-79826d0e65bc@linux.ee>
 <20200220121451.GA18071@gallifrey>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <6050ed14-f7a6-cb99-7268-072129226d48@linux.ee>
Date:   Thu, 20 Feb 2020 14:43:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200220121451.GA18071@gallifrey>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It looks like not all chips have temp_label, so I think we need to change w83627ehf_is_visible
> which has:
> 
>                  if (attr == hwmon_temp_input || attr == hwmon_temp_label)
>                          return 0444;
> 
> to
>                  if (attr == hwmon_temp_input)
>                          return 0444;
>                  if (attr == hwmon_temp_label) {
>                          if (data->temp_label)
> 				return 0444;
> 			else
> 				return 0;
>                  }
> 
> Does that work for you?
Yes, it works - sensors are displayed as they should be, with nothing in dmesg.

Thank you for so quick response!

-- 
Meelis Roos <mroos@linux.ee>
