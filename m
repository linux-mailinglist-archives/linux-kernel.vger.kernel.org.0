Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2B819791
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 06:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfEJEd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 00:33:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41634 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfEJEd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 00:33:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4A4XiQJ043797;
        Fri, 10 May 2019 04:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=DnWxQah1Do/p8EcIEEk2BiuTUT59Z4lUEvulq0K5mhc=;
 b=3MoHNAChqFlsCkP77/nGN+VS1G0RkB6PQoQS+kDQ/kOn4FJ4PHSL8ImWCPRF0TZUaxZN
 BximiYmSacqyiPejbpmU9fUjvyt0TDSdFtiKVZgoiqrWd3SyyNif8aLmiKUbqVhgrTL5
 Ir4CSeL1kwItQL2RMBT/ymr9LsVxE0h8H22Yx0+Fx9YJgn/OZaAbz4d5dUN3+7dyDD0Y
 ziU2h8VCQWJxM4zPLwd8FeQjAlR/Q3UO+iGbOvuJM1OBn45YxIGv2SCTarTje1af+jxc
 eUQJUZJVJXDKK8TmWKfSRTqb9CMphOfxsAIep+8Ebvi8rT4suGjQdOH2H+60gY0JZIPq 5w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2s94bgep2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 04:33:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4A4XLbN157217;
        Fri, 10 May 2019 04:33:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2schw0733d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 04:33:42 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4A4XbSt014833;
        Fri, 10 May 2019 04:33:37 GMT
Received: from dhcp-10-65-129-1.vpn.oracle.com (/10.65.129.1)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 May 2019 04:33:36 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] mm: vmscan: correct nr_reclaimed for THP
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <87tve3j9jf.fsf@yhuang-dev.intel.com>
Date:   Thu, 9 May 2019 22:33:35 -0600
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, hannes@cmpxchg.org,
        mhocko@suse.com, mgorman@techsingularity.net,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <640160C2-4579-45FC-AABB-B60185A2348D@oracle.com>
References: <1557447392-61607-1-git-send-email-yang.shi@linux.alibaba.com>
 <87y33fjbvr.fsf@yhuang-dev.intel.com>
 <1fb73973-f409-1411-423b-c48895d3dde8@linux.alibaba.com>
 <87tve3j9jf.fsf@yhuang-dev.intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=582
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905100032
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=617 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905100032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 9, 2019, at 9:03 PM, Huang, Ying <ying.huang@intel.com> wrote:
> 
> Yang Shi <yang.shi@linux.alibaba.com> writes:
> 
>> On 5/9/19 7:12 PM, Huang, Ying wrote:
>>> 
>>> How about to change this to
>>> 
>>> 
>>>         nr_reclaimed += hpage_nr_pages(page);
>> 
>> Either is fine to me. Is this faster than "1 << compound_order(page)"?
> 
> I think the readability is a little better.  And this will become
> 
>        nr_reclaimed += 1
> 
> if CONFIG_TRANSPARENT_HUAGEPAGE is disabled.

I find this more legible and self documenting, and it avoids the bit shift
operation completely on the majority of systems where THP is not configured.


