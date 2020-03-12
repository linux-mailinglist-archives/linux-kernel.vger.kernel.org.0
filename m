Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F041182719
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 03:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbgCLClh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 22:41:37 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43120 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387501AbgCLClh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 22:41:37 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8167120B9C02;
        Wed, 11 Mar 2020 19:41:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8167120B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1583980896;
        bh=FPn0J0a+i5WpPQn+wWi5l3mA8piuchfQOex4GqLMil0=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Lq9bjLEBp7SL0Z6FdOGkbsBEfiXIiOB12effq3ESopNg/WxdNEjjthlzf7xMDmeAr
         ksJOTlMvOTT49LGJ9z22mYxrAW2tGwOg59w69Vo8YhWOaOeJYfGmbJfkDVDbnqwmi4
         EyWcjHr0Sf3O2tCS609q9IHQZFhVi2bv+KVqVI9E=
Subject: Re: [Outreachy kernel] [PATCH] Staging: rtl8723bs: rtw_mlme: Remove
 unnecessary conditions
To:     Shreeya Patel <shreeya.patel23498@gmail.com>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        sbrivio@redhat.com, daniel.baluta@gmail.com, hverkuil@xs4all.nl,
        Larry.Finger@lwfinger.net
References: <20200311135859.5626-1-shreeya.patel23498@gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <61a6c3d7-6592-b57b-6466-995309302cc2@linux.microsoft.com>
Date:   Wed, 11 Mar 2020 19:42:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311135859.5626-1-shreeya.patel23498@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/2020 6:58 AM, Shreeya Patel wrote:

> Remove unnecessary if and else conditions since both are leading to the
> initialization of "phtpriv->ampdu_enable" with the same value.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>

Stating this based on the patch descriptions I have seen.
Others, please advise\correct me if I am wrong.

Patch description should state the problem first[1] and then describe 
how that is fixed in the given patch.

For example:

In the function rtw_update_ht_cap(), phtpriv->ampdu_enable is set to the 
same value in both if and else statements.

This patch removes this unnecessary if-else statement.


[1] Documentation\process\submitting-patches.rst
        2) Describe your changes

Thanks,
  -lakshmi
