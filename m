Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D76D16EDDB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 19:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731502AbgBYSUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 13:20:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727983AbgBYSUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:20:53 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PIKkqY037608;
        Tue, 25 Feb 2020 13:20:46 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yd4gr1yua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 13:20:46 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01PIANLD025248;
        Tue, 25 Feb 2020 18:20:45 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03wdc.us.ibm.com with ESMTP id 2yaux6e0qg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 18:20:45 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01PIKiqU35062182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 18:20:44 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2A83AE05C;
        Tue, 25 Feb 2020 18:20:44 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A070AE05F;
        Tue, 25 Feb 2020 18:20:40 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 25 Feb 2020 18:20:40 +0000 (GMT)
Subject: Re: [PATCH v2 3/4] tpm: Implement tpm2_init to call when
 TPM_OPS_AUTO_STARTUP is not set
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        nayna@linux.vnet.ibm.com, gcwilson@linux.ibm.com, jgg@ziepe.ca
References: <20200213202329.898607-1-stefanb@linux.vnet.ibm.com>
 <20200213202329.898607-4-stefanb@linux.vnet.ibm.com>
 <20200225170015.GE15662@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <3813980a-6c5e-c99f-7b37-b20b72eb6a8a@linux.ibm.com>
Date:   Tue, 25 Feb 2020 13:20:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200225170015.GE15662@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_06:2020-02-25,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002250130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 12:00 PM, Jarkko Sakkinen wrote:
> On Thu, Feb 13, 2020 at 03:23:28PM -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Implement tpm2_init() that gets the TPM 2 timeouts and command durations
>> and command code attributes. This function is to be called in case the
>> TPM_OPS_AUTO_STARTUP flag is not set and therefore tpm2_auto_startup()
>> is not called.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> The commit makes zero effort trying to explain what the heck tpm_init()
> is and when it should be used and why the function name tpm2_init().

Are you saying the explanation of when to use tpm2_init above is not 
enough? 'bviously we are trying to cover the case of using the TPM 2 by 
a driver that doesn't use the TPM_OPS_AUTO_STARTUP flag and therefore 
the TPM 2 timeouts and command durations and command code attributes are 
not set as they would be if tpm2_auto_startup() was to be called and 
tpm2_init() is the alternative to call. I didn't like tpm2_init() 
either... any suggestions for a better name?

    Stefan


>
> /Jarkko


