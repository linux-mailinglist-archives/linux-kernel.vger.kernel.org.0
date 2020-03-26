Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C22A194675
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 19:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgCZS1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 14:27:19 -0400
Received: from linux.microsoft.com ([13.77.154.182]:57122 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgCZS1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 14:27:18 -0400
Received: from [192.168.0.109] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 87EE220B4737;
        Thu, 26 Mar 2020 11:27:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 87EE220B4737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1585247237;
        bh=o38dnb32CGjX8brBUo5ZouRpDyVR7JANEbmWnk2DbUU=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=bZymhhX+VPOoHNwMoJgxan6I7+DGZTBmGuKMza4vKzlWiWCfLq8FrRpPUkpFz9P58
         5rAHHCrvJdAQTRuKPiD5Jsxaq7DxHoW5OcbjdlWKJoAy4vUW771WwG2DXiTGGH1Qfd
         5LiULj+UfirXnyVf22yPVBW5pNe+XxmEvP0jDfyY=
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: hal: Compress
 return logic
To:     Simran Singhal <singhalsimran0@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <20200325214312.GA1936@simran-Inspiron-5558>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <27ca4063-f34b-030d-f593-1d9a4f3c1165@linux.microsoft.com>
Date:   Thu, 26 Mar 2020 11:27:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200325214312.GA1936@simran-Inspiron-5558>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/20 2:43 PM, Simran Singhal wrote:

> Simplify function returns by merging assignment and return into
> one command line.

"Simplify function returns by merging assignment and return into one line".

You could change the subject also to "Simplify function return logic".

thanks,
  -lakshmi
