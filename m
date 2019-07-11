Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE8B1646E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 15:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfGJNU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 09:20:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49210 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJNU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:20:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6ADInaE107782;
        Wed, 10 Jul 2019 13:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=/5yLM4mbjzRmIXEHs2SJpsLnDoPmJ/wHA+9zC34Et+A=;
 b=44QOVwEm79DAncWafsxnHgQ4xniDJlHQMOsEiknXsA7lyLpqB7KM2/dWkubOaTVPDAc9
 IDm3SwNOrJtBwffuEY29Vs2VbyiFaMLSZ5BnDazCpwuliRyaqykaTT6N4CBXkJf1KRIG
 HNNMG2Bn9OKjYnxr8tvxthTRPWW0iCEC8A8XIGCwbfceBkM9qrqES3XtyQ49WE8EkstY
 ow7sw18v7F5Wzh8B/FD2o8HsHgFsqVwIQ2Uu9dohWBbNlEPpTY/LJSdnYXA6pY1VArko
 zjwKYMVTP+P/Q/U67OmDnOm+3CoEaMkRKs73qbGBfRm4Cx6Qu8y/vaf7AiU4TbVyx31Y tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tjkkpt3jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jul 2019 13:20:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6ADIEJx030597;
        Wed, 10 Jul 2019 13:20:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tnc8suxcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jul 2019 13:20:07 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6ADK6dQ000835;
        Wed, 10 Jul 2019 13:20:06 GMT
Received: from bostrovs-us.us.oracle.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Jul 2019 06:20:05 -0700
Subject: Re: [PATCH v6 4/4] x86/xen: Add "nopv" support for HVM guest
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, jgross@suse.com,
        sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
References: <1562490908-17882-1-git-send-email-zhenzhong.duan@oracle.com>
 <1562490908-17882-5-git-send-email-zhenzhong.duan@oracle.com>
 <86b0dbb9-74a7-6883-e6d7-210bd35a6944@oracle.com>
 <6cbd7b78-3d8d-64ae-fd2e-82244dbe6a1e@oracle.com>
 <3d7db7c6-cea3-9dce-0519-a1c600b33273@oracle.com>
 <33876a98-9b6b-a1b9-e72f-352c3f95db89@oracle.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <71b06655-79d2-97ae-cb6d-e0e606c8237f@oracle.com>
Date:   Wed, 10 Jul 2019 09:21:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <33876a98-9b6b-a1b9-e72f-352c3f95db89@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9313 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907100156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9313 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907100156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/19 10:07 PM, Zhenzhong Duan wrote:
> On 2019/7/9 22:54, Boris Ostrovsky wrote:
>> On 7/9/19 12:20 AM, Zhenzhong Duan wrote:
>>> -const __initconst struct hypervisor_x86 x86_hyper_xen_hvm = {
>>> +static uint32_t __init xen_platform_hvm(void)
>>> +{
>>> +       uint32_t xen_domain = xen_cpuid_base();
>>> +       struct x86_hyper_init *h = &x86_hyper_xen_hvm.init;
>>> +
>>> +       if (xen_pv_domain())
>>> +               return 0;
>>> +
>>> +       if (xen_pvh_domain() && nopv) {
>>> +               /* Guest booting via the Xen-PVH boot entry goes
>>> here */
>>> +               pr_info("\"nopv\" parameter is ignored in PVH
>>> guest\n");
>>> +               nopv = false;
>>> +       } else if (nopv && xen_domain) {
>>> +               /*
>>> +                * Guest booting via normal boot entry (like via
>>> grub2) goes
>>> +                * here.
>>> +                *
>>> +                * Use interface functions for bare hardware if nopv,
>>> +                * xen_hvm_guest_late_init is an exception as we
>>> need to
>>> +                * detect PVH and panic there.
>>> +                */
>>> +               memcpy(h, (void *)&x86_init.hyper,
>>> sizeof(x86_init.hyper));
>>
>> And this worked? I'd think it would fail since h points to RO section.
> Yes, I have below changes in the patch.
>
> -const __initconst struct hypervisor_x86 x86_hyper_xen_hvm = {
> +struct hypervisor_x86 x86_hyper_xen_hvm __initdata = {


But hypervisors[] stays__initconst so that I thought could be a problem.
But apparently it's not.

>
>>
>>
>>> +               memcpy(&x86_hyper_xen_hvm.runtime, (void
>>> *)&x86_platform.hyper,
>>> +                      sizeof(x86_platform.hyper));
>>> +               h->guest_late_init = xen_hvm_guest_late_init;
>>
>> To me this still doesn't look right --- you are making assumptions about
>> x86_platform/x86_init.hyper and I don't think you can assume they have
>> not been set to point to another hypervisor, for example.
>
> You mean copy_array() calls in init_hypervisor_platform()? But that
> happens after
>
> detect_hypervisor_vendor() shoose out the prefered hypervisor. In
> detect stage,
>
> x86_platform/x86_init.hyper has default value for bare hardware, or I
> missed something?


Right. My point though is that this ordering is opaque to
hypervisor-specific code and can change. The same is true about making
assumptions about x86_platform/x86_init.hyper values.

-boris


